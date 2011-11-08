require 'spec_helper'

describe RidesController do

  def valid_attributes
    FactoryGirl.attributes_for :ride
  end

  describe "when I am not signed in" do
    describe "GET index" do
      it "should redirect to the sign in page" do
        get :index
        response.should redirect_to new_user_session_path
      end
    end
  end

  describe "when I am signed in" do
    before do
      sign_in_user
    end

    describe "GET index" do
      it "assigns all rides as @rides" do
        ride = FactoryGirl.create :ride, :user => @user
        get :index
        assigns(:rides).should eq([ride])
      end
    end

    describe "GET show" do
      it "assigns the requested ride as @ride" do
        ride = FactoryGirl.create :ride, :user => @user
        get :show, :id => ride.id
        assigns(:ride).should eq(ride)
      end
    end

    describe "GET new" do
      it "assigns a new ride as @ride" do
        get :new
        assigns(:ride).should be_a_new(Ride)
      end
    end

    describe "GET edit" do
      it "assigns the requested ride as @ride" do
        ride = FactoryGirl.create :ride, :user => @user
        get :edit, :id => ride.id
        assigns(:ride).should eq(ride)
      end
    end

    describe "POST create" do
      describe "with valid params" do
        it "creates a new Ride" do
          expect {
            post :create, :ride => valid_attributes.merge( :user_id => @user.to_param )
          }.to change(Ride, :count).by(1)
        end

        it "assigns a newly created ride as @ride" do
          post :create, :ride => valid_attributes.merge( :user_id => @user.to_param )
          assigns(:ride).should be_a(Ride)
          assigns(:ride).should be_persisted
        end

        it "redirects to the created ride" do
          post :create, :ride => valid_attributes.merge( :user_id => @user.to_param )
          response.should redirect_to(Ride.last)
        end
      end

      describe "with invalid params" do
        it "assigns a newly created but unsaved ride as @ride" do
          # Trigger the behavior that occurs when invalid params are submitted
          Ride.any_instance.stub(:save).and_return(false)
          post :create, :ride => {}
          assigns(:ride).should be_a_new(Ride)
        end

        it "re-renders the 'new' template" do
          # Trigger the behavior that occurs when invalid params are submitted
          Ride.any_instance.stub(:save).and_return(false)
          post :create, :ride => {}
          response.should render_template("new")
        end
      end
    end

    describe "PUT update" do
      describe "with valid params" do
        it "updates the requested ride" do
          ride = FactoryGirl.create :ride, :user => @user
          Ride.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
          put :update, :id => ride.id, :ride => {'these' => 'params'}
        end

        it "assigns the requested ride as @ride" do
          ride = FactoryGirl.create :ride, :user => @user
          put :update, :id => ride.id, :ride => valid_attributes
          assigns(:ride).should eq(ride)
        end

        it "redirects to the ride" do
          ride = FactoryGirl.create :ride, :user => @user
          put :update, :id => ride.id, :ride => valid_attributes
          response.should redirect_to(ride)
        end
      end

      describe "with invalid params" do
        it "assigns the ride as @ride" do
          ride = FactoryGirl.create :ride, :user => @user
          # Trigger the behavior that occurs when invalid params are submitted
          Ride.any_instance.stub(:save).and_return(false)
          put :update, :id => ride.id, :ride => {}
          assigns(:ride).should eq(ride)
        end

        it "re-renders the 'edit' template" do
          ride = FactoryGirl.create :ride, :user => @user
          # Trigger the behavior that occurs when invalid params are submitted
          Ride.any_instance.stub(:save).and_return(false)
          put :update, :id => ride.id, :ride => {}
          response.should render_template("edit")
        end
      end
    end

    describe "DELETE destroy" do
      it "destroys the requested ride" do
        ride = FactoryGirl.create :ride, :user => @user
        expect {
          delete :destroy, :id => ride.id
        }.to change(Ride, :count).by(-1)
      end

      it "redirects to the rides list" do
        ride = FactoryGirl.create :ride, :user => @user
        delete :destroy, :id => ride.id
        response.should redirect_to(rides_url)
      end
    end
  end

end
