module ApplicationHelper

  def path_to_stripe(stripe)
    id = "0" * (6 - stripe.id.to_s.length) + stripe.id.to_s
    "/#{id}"
  end

  def clean_url(url)
    if url =~ /http/
      url
    else
      "http://#{url}"
    end
  end
end
