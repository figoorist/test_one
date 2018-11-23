class SendController < ApplicationController
  before_action :params_validation, only: [:new]

  def new
  	if SendMessageJob.set(wait: DateTime.parse(params[:date]).to_time.to_i).perform_later([params["text"], User.find(params["user_id"])])
      json_response(messenger: User.find(params["user_id"]).messenger.name)
    end
  end

  private

	def params_validation
	  errors = []

	  unless User.exists?(params['user_id'])
	  	errors.push("User doesn\'t exist")
	  end

	  unless !params['text'].to_s.empty?
	  	errors.push("Text can't be empty")
	  end

	  date = DateTime.parse(params[:date]) rescue false
	  unless date
	  	errors.push("Invalid date")
	  end

	  unless errors.empty?
	  	json_response({ error: errors.to_s }, :unprocessable_entity)
	  end
	end
end
