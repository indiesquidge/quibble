class CurrentUser < Draper::Decorator
  delegate_all


  def session_url
    if object
      h.link_to("Logout",
                h.logout_path,
                method: :delete)
    else
      h.link_to("Login with GitHub",
                "/auth/github",
                method: :get)
    end
  end

  def create_room_url
    if object && !h.current_page?(h.new_room_path)
      h.link_to("Create New Room",
                h.new_room_path)
    else
      ""
    end
  end
  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

end
