class EmailsController < ApplicationController
  before_action :set_email, only: %i[ show edit update destroy ]

  # GET /emails or /emails.json
  def index
    @emails = Email.order(read: :asc, created_at: :desc)
    @count = Email.count
  end
  

  # GET /emails/1 or /emails/1.json
  def show
    @email.update(read: true)
  end

  # GET /emails/new
  def new
    @email = Email.new
  end

  # GET /emails/1/edit
  def edit
  end

  def test
  end

  # POST /emails or /emails.json
  def create
    @email = Email.new(object: Faker::Lorem.sentence,
      body: Faker::Lorem.paragraphs(number: 3).join("\n"), read: false)

      
      if @email.save
        puts "email is success"
        refresh_emails
      else
        puts "email is failed"
      end

  end

  # PATCH/PUT /emails/1 or /emails/1.json
  def update
      if @email.update(email_params)
        render :show
      else
        render :edit
      end
    end

  # DELETE /emails/1 or /emails/1.json
  def destroy
    @email.destroy
    redirect_to emails_path, notice: 'Email supprimé !'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def refresh_emails
      render turbo_stream: [
              turbo_stream.update("email_counter", Email.count),
              turbo_stream.prepend("refresh_email",
                                  partial: "emailsindex",
                                  locals: { email: @email})]
                  
    end


    def refresh_read_emails
      render turbo_stream:
        turbo_stream.update("refresh_email",
                          partial: "emailsindex",
                          locals: { email: @email})
    end

    def remove_email
      render turbo_stream:[
              turbo_stream.remove(@email),
              turbo_stream.update("email_counter", Email.count),
            ]
    end



    def set_email
      @email = Email.find(params[:id])
      @count = Email.count
    end

   
    # Only allow a list of trusted parameters through.
    def email_params
      params.require(:email).permit(:object, :body)
    end
end
