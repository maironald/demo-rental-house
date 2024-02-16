# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RoomsController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let!(:room) { create(:room) }

  before do
    allow(controller).to receive(:authenticate_user!).and_return(true)
    allow(controller).to receive(:current_user).and_return(user)
  end

  describe 'GET #index' do
    let!(:room1) { create(:room, user:) }
    let!(:room2) { create(:room, user:) }
    let!(:renter1) { create(:renter, room: room1) }
    let!(:renter2) { create(:renter, room: room1) }

    before do
      sign_in user
    end

    it 'assigns all rooms as @rooms' do
      get :index
      expect(assigns(:rooms)).to match_array([room1, room2])
    end

    it 'assigns the total number of rooms' do
      get :index
      expect(assigns(:total_rooms)).to eq(2)
    end

    context 'when searching by name' do
      it 'assigns filtered rooms as @rooms' do
        get :index, params: { search: room1.name }
        expect(assigns(:rooms)).to eq([room1])
      end
    end

    context 'when filtering by rented rooms' do
      before do
        room1.renters << renter1
      end

      it 'assigns rented rooms as @rooms' do
        get :index, params: { selected_value: 'rented' }
        expect(assigns(:rooms)).to match_array([room1])
      end
    end

    context 'when filtering by empty rooms' do
      before do
        room1.renters.destroy_all
      end

      it 'assigns empty rooms as @rooms' do
        get :index, params: { selected_value: 'empty' }
        expect(assigns(:rooms)).to match_array([room1, room2])
      end
    end
  end
  describe 'GET #new' do
    it 'assigns a new room as @room' do
      get :new, format: :turbo_stream
      expect(assigns(:room)).to be_a_new(Room)
    end

    it 'renders the turbo_stream template' do
      get :new, format: :turbo_stream
      expect(response).to have_http_status(:success)
    end
  end
  describe 'POST create' do
    context 'with valid parameters' do
      let(:valid_params) { { room: attributes_for(:room) } }

      it 'creates a new room' do
        expect do
          post :create, params: valid_params
        end.to change(Room, :count).by(1)
      end

      it 'redirects to the rooms index' do
        post :create, params: valid_params
        expect(response).to redirect_to(rooms_path)
      end

      it 'sets a success notice' do
        post :create, params: valid_params
        expect(flash[:notice]).to eq('Room was successfully created.')
      end
    end

    context 'with invalid parameters' do
      let(:invalid_params) { { room: attributes_for(:room, name: nil) } }

      it 'does not create a new room' do
        expect do
          post :create, params: invalid_params, format: :turbo_stream
        end.not_to change(Room, :count)
      end

      it 'renders the new template with status :unprocessable_entity' do
        post :create, params: invalid_params, format: :turbo_stream
        expect(response).to render_template(:new)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'when the electric water amount is invalid' do
      let(:invalid_amount_params) { { room: attributes_for(:room) } }

      before do
        allow_any_instance_of(Room).to receive(:check_electric_water_amount).and_return(true)
      end

      it 'does not create a new room' do
        expect do
          post :create, params: invalid_amount_params, format: :turbo_stream
        end.not_to change(Room, :count)
      end

      it 'redirects to the rooms index with a failure notice' do
        post :create, params: invalid_amount_params
        expect(response).to redirect_to(rooms_path)
        expect(flash[:notice]).to eq('Room was created failed because the amount old is bigger than the amount new.')
      end
    end
  end
  describe 'PUT #update' do
    context 'when electric and water amounts are valid' do
      before do
        allow_any_instance_of(RoomsController).to receive(:check_amount).and_return(true)
      end

      it 'updates the room' do
        patch :update, params: { id: room.id, room: { name: 'Updated Room' } }
        room.reload
        expect(room.name).to eq('Updated Room')
      end

      it 'redirects to the rooms index' do
        patch :update, params: { id: room.id, room: { name: 'Updated Room' } }
        expect(response).to redirect_to(rooms_path)
      end

      it 'sets a success notice' do
        patch :update, params: { id: room.id, room: { name: 'Updated Room' } }
        expect(flash[:notice]).to eq('Room was successfully edited.')
      end
    end

    context 'when electric or water amounts are invalid' do
      before do
        allow_any_instance_of(RoomsController).to receive(:check_amount).and_return(false)
      end

      it 'does not update the room' do
        patch :update, params: { id: room.id, room: { name: 'Updated Room' } }
        room.reload
        expect(room.name).not_to eq('Updated Room')
      end

      it 'redirects to the rooms index with a failure notice' do
        patch :update, params: { id: room.id, room: { name: 'Updated Room' } }
        expect(response).to redirect_to(rooms_path)
        expect(flash[:notice]).to eq('Room was edited failed because the amount old is bigger than the amount new.')
      end
    end
  end
  describe 'DELETE destroy' do
    it 'destroys the room' do
      expect { delete :destroy, params: { id: room.id } }.to change(Room, :count).by(-1)
    end

    it 'redirects to rooms_path' do
      delete :destroy, params: { id: room.id }
      expect(response).to redirect_to(rooms_path)
    end

    it 'sets the flash notice' do
      delete :destroy, params: { id: room.id }
      expect(flash[:notice]).to eq('Room was successfully deleted.')
    end
  end
end
