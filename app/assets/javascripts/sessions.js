var Sessions = {}

Sessions.showPrompt = function(){
  swal({
    title: 'Melde Dich an',
    html: '' +
    '<form id="loginForm" action="/login" method="post">' +
    '  <input name="authenticity_token" type="hidden" value="' + $('meta[name="csrf-token"]').attr('content') + '"></input>' +
    '  <div class="form-group">' +
    '    <input name="email" type="email" placeholder="Email" class="form-control"></input><br/>' +
    '  </div>' +
    '  <div class="form-group">' +
    '    <input name="password" type="password" placeholder="Passwort" class="form-control"></input><br/>' +
    '  </div>' +
    '</form>',
    showCancelButton: true,
    confirmButtonText: 'Log in',
    allowOutsideClick: false
  }).then((result) => {
    $('form#loginForm').submit();
  })
};
