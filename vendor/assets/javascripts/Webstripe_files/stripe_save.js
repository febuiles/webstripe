(function() {
  this.JST || (this.JST = {});
  this.JST["admin/stripe_items/stripe_save"] = function(__obj) {
    if (!__obj) __obj = {};
    var __out = [], __capture = function(callback) {
      var out = __out, result;
      __out = [];
      callback.call(this);
      result = __out.join('');
      __out = out;
      return __safe(result);
    }, __sanitize = function(value) {
      if (value && value.ecoSafe) {
        return value;
      } else if (typeof value !== 'undefined' && value != null) {
        return __escape(value);
      } else {
        return '';
      }
    }, __safe, __objSafe = __obj.safe, __escape = __obj.escape;
    __safe = __obj.safe = function(value) {
      if (value && value.ecoSafe) {
        return value;
      } else {
        if (!(typeof value !== 'undefined' && value != null)) value = '';
        var result = new String(value);
        result.ecoSafe = true;
        return result;
      }
    };
    if (!__escape) {
      __escape = __obj.escape = function(value) {
        return ('' + value)
          .replace(/&/g, '&amp;')
          .replace(/</g, '&lt;')
          .replace(/>/g, '&gt;')
          .replace(/"/g, '&quot;');
      };
    }
    (function() {
      (function() {
        __out.push('<!--done-stripe-container-->\n\t<div class="done-stripe-container">\n\t<div class="spripe-box-top">\n\t\t<div class="stripe-done-left">\n\t\t\t<p class="title">Give your story name:</p>\n\t\t\t<div class="stripe-name">\n\t\t\t\t<input name="stripe-name" type="text" class="stripe-name-input">\n\t\t\t</div>\n\t\t\t<div class="align-options">\n\t\t\t\t<p class="title">And choose the orientation:</p>\n\t\t\t\t<div id="vertical">\n\t\t\t<input type="radio" name="alignment" value="vertical" /><br /></div>\n\t\t\t\t<div id="horizontal">\n\t\t\t<input type="radio" name="alignment" value="horizontal" /><br /></div>\n\t\t\t</div>\n\t\t\t<div class="clearfix"></div>\n\t\t\t<div class="done-button">\n\t\t\t\t<a href="#"><img src="/assets/doneredicon.png" alt="Done"/>Done</a>\n\t\t\t</div>\n\t\t</div>\n\t\t<div class="stripe-options">\n\t\t\t<ul id="stripe-menu">\n\t\t\t\t<li class="back-to-editor"><a href="#"><img src="/assets/backtoeditoricon.png" alt="Back to editor"/><span class="link-text">Back to editor</span></a></li>\n\t\t\t</ul>\n\t\t</div>\n\n\t</div>\n\t</div>\n<!--end-done-stripe-container-->\n');
      
      }).call(this);
      
    }).call(__obj);
    __obj.safe = __objSafe, __obj.escape = __escape;
    return __out.join('');
  };
}).call(this);
