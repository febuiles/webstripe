(function() {
  var _ref,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  StripeAdmin.Views.EditStripeItem = (function(_super) {
    __extends(EditStripeItem, _super);

    function EditStripeItem() {
      _ref = EditStripeItem.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    EditStripeItem.prototype.template = JST['admin/stripe_items/slide'];

    EditStripeItem.prototype.tagName = 'div';

    EditStripeItem.prototype.events = {
      'click .queue.add': 'newSlide',
      'click .queue.remove': 'removeSlide',
      'click .done-slide': 'saveStripe',
      'focus .stripe-input-content': 'hideBg',
      'blur .stripe-input-content': 'showBg'
    };

    EditStripeItem.prototype.initialize = function() {
      this.model.on('change', this.render, this);
      this.model.on('remove', this.remove, this);
      this.model.on('drawLink', this.drawNewLink, this);
      this.model.on('removeLink', this.hideRemoveLink, this);
      return this.model.on('showLink', this.showRemoveLink, this);
    };

    EditStripeItem.prototype.render = function() {
      $(this.el).html(this.template({
        stripe_item: this.model
      }));
      this.collection.trigger('drawNewLink');
      this.collection.trigger('drawRemoveLink');
      return this;
    };

    EditStripeItem.prototype.newSlide = function(event) {
      var _this = this;

      event.preventDefault();
      event.stopPropagation();
      if ($.trim(this.$('.stripe-input-content').val()) !== '') {
        this.model.unset("errors");
        this.model.set('content', $.trim(this.$('.stripe-input-content').val()));
        this.collection.create(this.model, {
          success: function(stripe_item) {
            var view;

            console.log("Success");
            view = new StripeAdmin.Views.ShowStripeItem({
              model: stripe_item
            });
            return $(_this.el).parent().prev().find('.stripe').append(view.render().el);
          },
          error: function(stripe_item, jqXHR) {
            return _this.model.set({
              errors: $.parseJSON(jqXHR.responseText)
            });
          }
        });
      }
      return this.collection.trigger('newSlide');
    };

    EditStripeItem.prototype.removeSlide = function(event) {
      event.preventDefault();
      this.collection.remove(this.model);
      this.model.destroy();
      this.collection.trigger('drawNewLink');
      return this.collection.trigger('drawRemoveLink');
    };

    EditStripeItem.prototype.drawNewLink = function() {
      $('.queue.add').hide();
      return this.$('.queue.add').show();
    };

    EditStripeItem.prototype.hideRemoveLink = function() {
      return this.$('.queue.remove').hide();
    };

    EditStripeItem.prototype.showRemoveLink = function() {
      return this.$('.queue.remove').show();
    };

    EditStripeItem.prototype.hideBg = function() {
      return this.$('.stripe-input-content').focus(function() {
        return $(this).css("background", "none");
      });
    };

    EditStripeItem.prototype.showBg = function() {
      return this.$('.stripe-input-content').blur(function() {
        if ($.trim($(this).val()) === '') {
          return $(this).css("background", "url('/assets/stripeinputbg.png') top left no-repeat");
        }
      });
    };

    EditStripeItem.prototype.saveStripe = function(event) {
      var _this = this;

      event.preventDefault();
      event.stopPropagation();
      if ($.trim(this.$('.stripe-input-content').val()) !== '') {
        this.model.unset("errors");
        this.model.set('content', $.trim(this.$('.stripe-input-content').val()));
        return this.collection.create(this.model, {
          success: function(stripe_item) {
            return console.log("Success");
          },
          error: function(stripe_item, jqXHR) {
            return _this.model.set({
              errors: $.parseJSON(jqXHR.responseText)
            });
          }
        });
      }
    };

    return EditStripeItem;

  })(Backbone.View);

}).call(this);
