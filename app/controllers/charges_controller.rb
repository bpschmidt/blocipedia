class ChargesController < ApplicationController

  def create
     # Creates a Stripe Customer object, for associating
     # with the charge
     @amount = 500

     customer = Stripe::Customer.create(
      :email => params[:stripeEmail],
      :source  => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @amount,
      :description => 'Rails Stripe customer',
      :currency    => 'usd'
       )

       current_user.update_attributes(:role => 'premium')

     flash[:notice] = "Thanks for all the money, #{current_user.email}! Feel free to pay me again."
     redirect_to user_path(current_user) # or wherever

     # Stripe will send back CardErrors, with friendly messages
     # when something goes wrong.
     # This `rescue block` catches and displays those errors.
     rescue Stripe::CardError => e
       flash[:alert] = e.message
       redirect_to new_charge_path
   end

  def new
    @stripe_btn_data = {
     key: "#{ Rails.configuration.stripe[:publishable_key] }",
     description: "BigMoney Membership - #{current_user.email}",
     amount: 500
    }
  end

  def destroy
    current_user.update_attributes(:role => 'standard')
    redirect_to :back, notice: "User has been successfully downgraded."
  end
end
