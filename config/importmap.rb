# Pin npm packages by running ./bin/importmap

pin 'application', preload: true

pin '@rails/actioncable', to: 'actioncable.esm.js'
pin '@rails/activestorage', to: 'activestorage.esm.js'
pin '@rails/actiontext', to: 'actiontext.esm.js'
pin 'trix'

pin 'jquery', to: 'https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js', preload: true
pin '@fortawesome/fontawesome-free', to: 'https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/js/fontawesome.js'
pin 'inputmask', to: 'https://cdnjs.cloudflare.com/ajax/libs/jquery.inputmask/5.0.9/jquery.inputmask.js'
pin 'toastr', to: 'https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js'
pin 'bootstrap', to: 'https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.3/js/bootstrap.min.js'

pin_all_from 'app/javascript/packs', under: 'packs', to: 'packs'
