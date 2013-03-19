describe "Slide model", ->
  beforeEach ->
    @slide = new StripeAdmin.Models.Slide({stripe_id: "one"})

  describe "when instantiated", ->
    it "should exhibit attributes", ->
      expect(@slide.get("stripe_id")).toEqual("one")