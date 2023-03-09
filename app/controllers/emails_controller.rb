class EmailsController < ApplicationController
  before_action :set_email, only: %i[ show edit update destroy ]

  # GET /emails or /emails.json
  def index
    @emails = (Email.all).order(created_at: :desc)
  end

  # GET /emails/1 or /emails/1.json
  def show
    @email = Email.find(params[:id])
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
      body: Faker::Lorem.paragraphs(number: 3).join("\n"))

      if @email.save
        puts "email is success"
      else
        puts "email is failed"
      end

      refresh_emails

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

    refresh_emails
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_email
      @email = Email.find(params[:id])
    end

    def refresh_emails
      render turbo_stream:
              turbo_stream.append("refresh_email",
                                  partial: "emailsindex",
                                  locals: { email: @email})
    end

    def remove_emails
      render turbo_stream:
              turbo_stream.append("refresh_email",
                                  partial: "emailsindex",
                                  locals: { email: @email})
    end

    # Only allow a list of trusted parameters through.
    def email_params
      params.require(:email).permit(:object, :body)
    end
end
