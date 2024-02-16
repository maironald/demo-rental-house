# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RentersController, type: :controller do
  before do
    allow(controller).to receive(:authenticate_user!).and_return(true)
    allow(controller).to receive(:current_user).and_return(user)
  end

  let(:user) { create(:user) }
  let(:room) { create(:room, user:) }
  let(:renter) { FactoryBot.create(:renter, room:) }

  before do
    sign_in user
  end

  describe 'GET #index' do
    context 'when user is signed in' do
      let(:user) { create(:user) }
      let(:room_ids) { [1, 2, 3] }

      before do
        sign_in user
        allow(controller).to receive(:current_user).and_return(user)
        allow(user).to receive_message_chain(:rooms, :pluck).and_return(room_ids)
      end

      it 'assigns @room_ids with rooms rented by current user' do
        get :index
        expect(assigns(:room_ids)).to eq(room_ids)
      end

      it 'assigns @renters with renters who have rented a room through current user' do
        renters = create_list(:renter, 3, room_id: room_ids.sample)
        get :index
        expect(assigns(:renters)).to eq(renters)
      end

      it 'searches renters by name if search parameter is present' do
        renters = create_list(:renter, 3, room_id: room_ids.sample, name: 'John Doe')
        get :index, params: { search: 'John' }
        expect(assigns(:renters)).to eq(renters)
      end

      it "filters renters by renter type if selected_value is 'main' or 'member'" do
        main_renters = create_list(:renter, 2, room_id: room_ids.sample, renter_type: 'main')
        member_renters = create_list(:renter, 2, room_id: room_ids.sample, renter_type: 'member')
        get :index, params: { selected_value: 'main' }
        expect(assigns(:renters)).to eq(main_renters)
        get :index, params: { selected_value: 'member' }
        expect(assigns(:renters)).to eq(member_renters)
      end

      it 'paginates @renters with 9 items per page' do
        create_list(:renter, 15, room_id: room_ids.sample)
        get :index
        expect(assigns(:renters).count).to eq(9)
        expect(assigns(:pagy).items).to eq(9)
      end
    end
  end

  # describe '#new' do
  #   it 'assigns a new renter to @renter' do
  #     get :new, format: :turbo_stream
  #     expect(assigns(:renters)).to be_a_new(Renter)
  #   end

  #   it 'renders the new turbo_stream template' do
  #     get :new, format: :turbo_stream
  #     expect(response).to render_template('new.turbo_stream.erb')
  #   end
  # end

  describe '#create' do
    let(:room) { create(:room) }

    context 'with valid params' do
      let(:valid_params) { { room_id: room.id, renter: attributes_for(:renter) } }

      it 'creates a new renter' do
        expect do
          post :create, params: valid_params
        end.to change(Renter, :count).by(1)
      end

      it 'redirects to the rooms path' do
        post :create, params: valid_params
        expect(response).to redirect_to(rooms_path)
      end

      # Add more tests for turbo stream rendering if needed
    end

    context 'with invalid params' do
      let(:invalid_params) { { room_id: room.id, renter: attributes_for(:renter, name: nil) } }

      it 'does not create a new renter' do
        expect do
          post :create, params: invalid_params, format: :turbo_stream
        end.to_not change(Renter, :count)
      end

      it 'renders the new template again' do
        post :create, params: invalid_params, format: :turbo_stream
        expect(response).to render_template(:new)
      end
    end
  end

  describe '#update' do
    let(:renter) { create(:renter) }

    context 'with valid params' do
      let(:valid_params) { { id: renter.id, renter: { name: 'Updated Name' } } }

      it 'updates the renter' do
        put :update, params: valid_params
        renter.reload
        expect(renter.name).to eq('Updated Name')
      end

      it 'redirects to the renters path' do
        put :update, params: valid_params
        expect(response).to redirect_to(renters_path)
      end

      # Add more tests for turbo stream rendering if needed
    end

    context 'with invalid params' do
      let(:invalid_params) { { id: renter.id, renter: { name: nil } } }

      it 'does not update the renter' do
        put :update, params: invalid_params, format: :turbo_stream
        renter.reload
        expect(renter.name).to_not be_nil
      end

      it 'renders the edit template again' do
        put :update, params: invalid_params, format: :turbo_stream
        expect(response).to render_template(:edit)
      end
    end
  end

  describe '#destroy' do
    let(:renter) { create(:renter) }

    it 'destroys the renter' do
      delete :destroy, params: { id: renter.id }
      expect(Renter.exists?(renter.id)).to be_falsey
    end

    it 'redirects to the renters path' do
      delete :destroy, params: { id: renter.id }
      expect(response).to redirect_to(renters_path)
    end

    it 'sets a flash notice message' do
      delete :destroy, params: { id: renter.id }
      expect(flash[:notice]).to eq('Renter was successfully deleted.')
    end
  end
end
