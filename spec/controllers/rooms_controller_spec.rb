# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RoomsController, type: :controller do
  let(:user) { create(:user) }
  let(:room) { create(:room, user:, electric_amount_old: 10, electric_amount_new: 20, water_amout_old: 30, water_amout_new: 40) }

  before { sign_in(user) }

  describe 'GET #index' do
    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #new' do
    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe 'GET #edit' do
    it 'renders the edit template' do
      get :edit, params: { id: room.id }, format: :turbo_stream
      expect(response).to render_template(:edit)
    end
  end

  describe 'PATCH #update' do
    let(:valid_params) { { id: room.id, room: { name: 'Updated Room' } } }

    it 'updates the room' do
      patch :update, params: valid_params
      room.reload
      expect(room.name).to eq('Updated Room')
      expect(response).to redirect_to(rooms_path)
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the room' do
      room # Ensure the room is created
      expect do
        delete :destroy, params: { id: room.id }
      end.to change(Room, :count).by(-1)

      expect(response).to redirect_to(rooms_path)
    end
  end
end
