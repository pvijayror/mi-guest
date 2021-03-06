class AccommodationsController < ApplicationController

  autocomplete :guest, :last_name, full: true, extra_data: [:first_name, :date_of_birth],
                                   display_value: :to_autocomplete

  def index
    if params[:month].blank? or params[:year].blank?
      @month = Date.today.month
      @year = Date.today.year
    else
      @month = params[:month].to_i
      @year = params[:year].to_i
    end

    @accommodations = Accommodation.filter_by_month_and_orderd_by_created_at_desc(@month, @year)
  end

  def print
    @accommodation = Accommodation.find(params[:accommodation_id])
  end

  def new
    @accommodation = Accommodation.new
  end

  def edit
    @accommodation = Accommodation.find(params[:id])
    @guest_name = @accommodation.guest.to_autocomplete
  end

  def create
    p params[:accomodation]
    @accommodation = Accommodation.new(params[:accommodation])

    if @accommodation.save
      flash[:notice] = t(:accommodations_create_notice)
      redirect_to action: "index"
    else
      render action: "new"
    end
  end

  def update
    @accommodation = Accommodation.find(params[:id])

    if @accommodation.update_attributes(params[:accommodation])
      flash[:notice] = t(:accommodations_update_notice)
      redirect_to action: "index"
    else
      render action: "edit"
    end
  end

  def destroy
    @accommodation = Accommodation.find(params[:id])
    @accommodation.destroy

    redirect_to accommodations_url
  end
end
