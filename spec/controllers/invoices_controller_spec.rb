# frozen_string_literal: true

require 'rails_helper'

RSpec.describe InvoicesController, type: :controller do
  describe '#create' do
    let(:room) { create(:room) }

    context 'with invalid params' do
      let(:invalid_params) { { room_id: room.id, invoice: attributes_for(:invoice, name: nil) } }

      it 'does not create a new invoice' do
        expect do
          post :create, params: invalid_params
        end.to_not change(Invoice, :count)
      end

      it 'returns unprocessable_entity status' do
        post :create, params: invalid_params
        expect(response).to have_http_status(:found)
      end
    end
  end

  describe 'GET #show_all_invoices' do
    let(:user) { create(:user) } # Assuming you have a factory for users
    let!(:room1) { create(:room, user:) }
    let!(:room2) { create(:room, user:) }
    let!(:invoice1) { create(:invoice, room: room1) }
    let!(:invoice2) { create(:invoice, room: room2) }

    before do
      sign_in user
    end

    it 'assigns the rooms of the current user to @room_ids' do
      get :show_all_invoices
      expect(assigns(:room_ids)).to match_array([room1.id, room2.id])
    end

    it 'assigns the filtered invoices to @invoices' do
      get :show_all_invoices
      expect(assigns(:invoices)).to match_array([invoice1, invoice2])
    end

    it 'applies search filtering if search parameter is present' do
      get :show_all_invoices, params: { search: invoice1.name }
      expect(assigns(:invoices)).to eq([invoice1])
    end

    it 'applies filtering for unpaid invoices if selected_value parameter is unpaid' do
      unpaid_invoice = create(:invoice, room: room1, total_price: 100, paid_money: 50)
      get :show_all_invoices, params: { selected_value: 'unpaid' }
      expect(assigns(:invoices)).to eq([invoice1, invoice2, unpaid_invoice])
    end

    it 'applies filtering for paid invoices if selected_value parameter is paid' do
      paid_invoice = create(:invoice, room: room1, total_price: 100, paid_money: 100)
      get :show_all_invoices, params: { selected_value: 'paid' }
      expect(assigns(:invoices)).to eq([paid_invoice])
    end

    it 'paginates @invoices' do
      get :show_all_invoices
      expect(assigns(:pagy)).to be_present
      expect(assigns(:invoices)).to be_present
    end

    it 'renders the show_all_invoices template' do
      get :show_all_invoices
      expect(response).to render_template(:show_all_invoices)
    end
  end
end
