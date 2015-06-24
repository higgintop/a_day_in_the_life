module UsersHelper
  #It then creates a url where that gravatar can be found
  #Following that, a image tag is created which upon render displays that gravatar image.
  #To user, just call this method on a user view.
  #See:
  #asciicasts.com/episodes/244-gravatar
  #Only addition is using the image tag within the method
  def gravatar_for(user)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag(gravatar_url, alt:user.name, class: "gravatar")
  end
end
