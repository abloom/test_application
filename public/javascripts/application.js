// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
function form_contents() {
  var form = $$('form').first();
  
  var form_els = form.getElements().reject(function(el) {
    return $w("_method authenticity_token").include(el.name);
  });
  var url_encoded = form_els.collect(function(el) {
    return(el.name + "=" + el.value);
  });
  
  return url_encoded.join("&");
}