class ChargesController < ApplicationController
  before_action :get_current_event, :get_amount, :only =>[:create, :new]

  def new
  end

  def create
    customer = Stripe::Customer.create({
      email: params[:stripeEmail],
      source: params[:stripeToken],
    })

    charge = Stripe::Charge.create({
      customer: customer.id,
      amount: @amount*100,
      description: 'Event entry',
      currency: 'EUR',
    })
    flash[:success] = "Payment of #{@amount} succeed, you are officially on the guest list of event #{@event.id}"
    redirect_to event_path(@event.id)
  rescue Stripe::CardError => e
    flash[:danger] = e.message
    redirect_to '/'
  rescue Exception => e
    flash[:danger] = e.message
    redirect_to '/'
  end

  private
  def get_current_event
    @event = Event.find(params[:event_id])
  end

  def get_amount
    @amount = @event.price
  end
end
