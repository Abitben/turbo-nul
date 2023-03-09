// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import * as bootstrap from "bootstrap"

console.log(document.getElementById('email_turbo'))
console.log(document.getElementById('refresh_email'))
var turbo = document.getElementById('refresh_email')
console.log(document.querySelector('.btn-refresh'))
var button = document.querySelector('.btn-refresh')

$(document).ready(function(){
  $(button).click(function(){
    $(turbo).fadeIn("slow");
  });
});
