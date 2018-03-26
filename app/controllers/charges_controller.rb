class ChargesController < ApplicationController

  def new
    # current_user.employer? redirect back to root -> already upgraded?
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "Employ Employer Membership - #{current_user.email}",
      amount: 1000
    }

    if current_user.employer?
      flash[:notice] = "You've already paid for that!"
      redirect_to root_path
    end
    # authorize @charge

  end

  def create
    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: 1000,
      description: "Employ Employer Membership - #{current_user.email}",
      currency: 'usd'
    )

    flash[:notice] = "Thanks for signing up for the employer account, #{current_user.email}! Now you're ready, post a new job!"
    current_user.employer!
    redirect_to root_path

    rescue Stripe::CardError => e
      flash[:alert] = e.message
      redirect_to new_charge_path
  end
end
