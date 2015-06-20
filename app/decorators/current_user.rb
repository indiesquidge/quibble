class CurrentUser < Draper::Decorator
  decorates :user
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

  def form_link(form)
    if object
      form.submit("Create room", class: "btn")
    else
      h.link_to("Login to create room",
                "/auth/github",
                class: "btn")
    end
  end

    def close_topic(room)
      if object == room.user
        h.button_to("Close this Topic",
                   h.room_path(room),
                   method: :put,
                   class: "btn col s12")
      else
        ""
      end
    end
end
