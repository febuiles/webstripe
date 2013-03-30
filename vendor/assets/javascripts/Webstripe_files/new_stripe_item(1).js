(function() {
  var _ref,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  StripeAdmin.Views.NewStripeItem = (function(_super) {
    __extends(NewStripeItem, _super);

    function NewStripeItem() {
      _ref = NewStripeItem.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    NewStripeItem.prototype.template = JST['admin/stripe_items/new_stripe_item'];

    NewStripeItem.prototype.el = "<div class='section new' id='new-stripe-item'/>";

    NewStripeItem.prototype.events = {
      'click .queue.add': 'createStripeItem',
      'click .queue.remove': 'removeSlide',
      'click .done-slide': 'saveStripe',
      'focus .stripe-input-content': 'hideBg',
      'blur .stripe-input-content': 'showBg'
    };

    NewStripeItem.prototype.render = function() {
      if (typeof console !== "undefined" && console !== null) {
        console.log("Rendering new stripe item");
      }
      $(this.el).html(this.template());
      return this;
    };

    NewStripeItem.prototype.createStripeItem = function(e) {
      var attributes;

      e.preventDefault();
      if ($.trim($('.stripe-input-content').val()) !== '') {
        attributes = {
          position: "1",
          content: $.trim($('.stripe-input-content').val()),
          image: "http://i.imgur.com/VFor0WA.jpg",
          item_type: "image"
        };
        this.parent.addStripeItem(attributes);
        return $(this.el).find("#new_stripe_item")[0].reset();
      }
    };

    NewStripeItem.prototype.removeSlide = function(e) {
      e.preventDefault();
      return $(this.el).find("#new_stripe_item")[0].reset();
    };

    NewStripeItem.prototype.hideBg = function() {
      return $('.stripe-input-content').focus(function() {
        return $(this).css("background", "none");
      });
    };

    NewStripeItem.prototype.showBg = function() {
      return this.$('.stripe-input-content').blur(function() {
        if ($.trim($(this).val()) === '') {
          return $(this).css("background", "url('/assets/stripeinputbg.png') top left no-repeat");
        }
      });
    };

    NewStripeItem.prototype.saveStripe = function() {
      return typeof console !== "undefined" && console !== null ? console.log("Set stripe on published status") : void 0;
    };

    return NewStripeItem;

  })(Support.CompositeView);

}).call(this);
