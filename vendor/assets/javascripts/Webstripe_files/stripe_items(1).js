(function() {
  var _ref,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  StripeAdmin.Views.StripeItems = (function(_super) {
    __extends(StripeItems, _super);

    function StripeItems() {
      this.renderSingleSlide = __bind(this.renderSingleSlide, this);      _ref = StripeItems.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    StripeItems.prototype.template = JST['admin/stripe_items/stripe'];

    StripeItems.prototype.el = "<div class='stripe' id='stripe-new' />";

    StripeItems.prototype.initialize = function() {
      this.collection.on('reset', this.renderSlides, this);
      return this.collection.on('add', this.renderSingleSlide, this);
    };

    StripeItems.prototype.render = function() {
      if (typeof console !== "undefined" && console !== null) {
        console.log('Rendering Stripe#new');
      }
      $(this.el).html(this.template());
      if (this.collection.any()) {
        this.renderSlides();
      }
      this.createNewSlideForm();
      return this;
    };

    StripeItems.prototype.leave = function() {
      this.collection.off();
      return typeof console !== "undefined" && console !== null ? console.log('Leaving Stripe#new') : void 0;
    };

    StripeItems.prototype.renderSingleSlide = function(stripe_item) {
      var view;

      view = new StripeAdmin.Views.ShowStripeItem({
        model: stripe_item
      });
      this.appendChildTo(view, ".stripe-items");
      return console.log("render single");
    };

    StripeItems.prototype.renderSlides = function() {
      $(this.el).find(".stripe-items").empty();
      this.collection.each(this.renderSingleSlide);
      return console.log("render slides");
    };

    StripeItems.prototype.createNewSlideForm = function() {
      var view;

      view = new StripeAdmin.Views.NewStripeItem();
      return this.appendChildTo(view, ".new-stripe-item");
    };

    StripeItems.prototype.addStripeItem = function(stripeItemAttributes) {
      var _this = this;

      if (typeof console !== "undefined" && console !== null) {
        console.log("Creating new stripe item", stripeItemAttributes);
      }
      return this.collection.create(stripeItemAttributes, {
        silent: true,
        "while": true,
        success: function(stripe_item) {
          console.log("before render single slide");
          _this.renderSingleSlide(stripe_item);
          stripe_item.trigger("add_content");
          return console.log(stripe_item.get('content'));
        },
        error: function() {
          return this.handleError;
        }
      });
    };

    StripeItems.prototype.handleError = function(entry, response) {
      var attribute, errors, message, messages, _results;

      if (response.status === 422) {
        errors = $.parseJSON(response, responseText).errors;
        _results = [];
        for (attribute in errors) {
          messages = errors[attribute];
          _results.push((function() {
            var _i, _len, _results1;

            _results1 = [];
            for (_i = 0, _len = messages.length; _i < _len; _i++) {
              message = messages[_i];
              _results1.push(alert("" + attribute + " " + message));
            }
            return _results1;
          })());
        }
        return _results;
      }
    };

    return StripeItems;

  })(Support.CompositeView);

}).call(this);
