(function() {
  // default to json
  $.ajaxSetup({
    dataType: 'json'
  });
  $.fn.render_form_errors = function(model_name, errors) {
    var form;
    form = this;
    this.clear_form_errors();
    return $.each(errors, function(field, messages) {
      var input;
      input = form.find('input, select, textarea').filter(function() {
        var name;
        name = $(this).attr('name');
        if (name) {
          return name.match(new RegExp(model_name + '\\[' + field + '\\(?'));
        }
      });
      input.closest('.form-group').addClass('has-error');
      return input.parent().append('<span class="help-block">' + $.map(messages, function(m) {
        return m.charAt(0).toUpperCase() + m.slice(1);
      }).join('<br />') + '</span>');
    });
  };

  $.fn.clear_form_errors = function() {
    this.find('.form-group').removeClass('has-error');
    return this.find('span.help-block').remove();
  };

  $.fn.clear_form_fields = function() {
    return this.find(':input', '#myform').not(':button, :submit, :reset, :hidden').val('').removeAttr('checked').removeAttr('selected');
  };

  $('form[data-modelname]').on("ajax:success", function(e, data, status, xhr){
    if(data.redirect){
      window.location.href = data.redirect;
    }
  }).on("ajax:error", function(e, data, status, xhr){
    model = $("form[data-modelname]").data('modelname');
    $("form[data-modelname]").render_form_errors(model, data.responseJSON);
  });

}).call(this);
