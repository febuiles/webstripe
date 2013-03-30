(function() {
  this.JST || (this.JST = {});
  this.JST["admin/stripe_items/slide"] = function(__obj) {
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
        __out.push('<!--stripe-container-->\n\t<div class="spripe-box-top">\n\t\t<div class="stripe-input">\n\t\t\t<textarea id="stripe-input-content" class="stripe-input-content">  </textarea>\n\t\t</div>\n\t\t<div class="stripe-options">\n\t\t\t<div class="stripe-number"><span class="number">');
      
        __out.push(__sanitize(this.stripe_item.get('position')));
      
        __out.push('</span></div>\n\t\t\t<ul id="stripe-menu">\n\t\t\t\t<li class="arrow-up"><a href="#"><img src="/assets/redarrow.png" alt="Move up"/><span class="link-text">Move up</span></a></li>\n\t\t\t\t<li class="arrow-down"><a href="#"><img src="/assets/redarrowdown.png" alt="Move down"/><span class="link-text">Move down</span></a></li>\n\t\t\t\t<li class="delete-stripe queue remove"><a href="#"><img src="/assets/reddelete.png" alt="Delete"/><span class="link-text">Delete</span></a></li>\n\t\t\t</ul>\n\t\t</div>\n\t\t<div class="add-image-container">\n\t\t\t<p>or <a href="#">select an image</a> to upload</p>\n\t\t</div>\n\t</div>\n\t<div class="stripe-box-bottom">\n\t\t<div class="stripe-bottom-options">\n\t\t\t<ul id="stripe-bottom-menu">\n\t\t\t\t<li class="new-slide queue add"><a href="#"><img src="/assets/addslideicon.png" alt="Add new slide"/>Add new slide</a></li>\n\t\t\t\t<li class="done-slide"><a href="#"><img src="/assets/doneicon.png" alt="Done"/>Done</a></li>\n\t\t\t</ul>\n\t\t</div>\n\t</div>\n<!--end-stripe-container-->\n');
      
      }).call(this);
      
    }).call(__obj);
    __obj.safe = __objSafe, __obj.escape = __escape;
    return __out.join('');
  };
}).call(this);
