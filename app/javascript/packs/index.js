// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

$(document).ready(function(){
  $(".cpf").inputmask("999.999.999-99");
  $(".cep").inputmask("99999-999");
  $(".phone").inputmask({
    "mask": ["(99) 9999-9999", "(99) 9 9999-9999", ],
    "keepStatic": true
  });
  $(".cnpj").inputmask("99.999.999/9999-99");
  $(".currency").inputmask('decimal', {
    "alias": "numeric",
    "groupSeparator": ".",
    "autoGroup": true,
    "digits": 2,
    "radixPoint": ",",
    "digitsOptional": false,
    "allowMinus": false,
    "prefix": "R$ ",
    "placeholder": "0",
    "rightAlign": false
  });
});

toastr.options = {
  "closeButton": true,
  "debug": false,
  "progressBar": true,
  "positionClass": "toast-top-left",
  "showDuration": "300",
  "hideDuration": "1000",
  "timeOut": "5000",
  "extendedTimeOut": "1000",
  "showEasing": "swing",
  "hideEasing": "linear",
  "showMethod": "fadeIn",
  "hideMethod": "fadeOut"
};

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)
