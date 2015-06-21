class CurrentUser < Draper::Decorator
  decorates :user
  delegate_all

  def session_url
    if user
      h.link_to("Logout",
                h.logout_path,
                method: :delete)
    else
      h.link_to("Login with GitHub",
                "/auth/github",
                method: :get)
    end
  end

  def close_topic(room)
    if user == room.user
      h.button_to("Close this Topic",
                  h.room_path(room),
                  method: :put,
                  class: "btn col s12")
    end
  end
end
