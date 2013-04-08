class StripeAdmin.Models.Stripe extends Backbone.RelationalModel
  paramRoot: 'stripe'
  urlRoot: '/admin/stripes'

  relations: [
    type: Backbone.HasMany
    key: 'stripe_items'
    relatedModel: 'StripeAdmin.Models.StripeItem'
    collectionType: 'StripeAdmin.Collections.StripeItems'
    includeInJSON: false
    reverseRelation:
      key: 'stripe_id'
      includeInJSON: 'id'
  ]