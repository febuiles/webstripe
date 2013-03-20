class StripeAdmin.Models.Stripe extends Backbone.RelationalModel.extend
  urlRoot: '/admin/stripes'
  idAttribute: '_id'
  relations: [{
    type: Backbone.HasMany,
    key: 'stripe_items',
    relatedModel: 'StripeAdmin.Models.StripeItem',
    reverseRelation: {
      key: 'stripe',
      includeInJSON: '_id',
    }
  }]