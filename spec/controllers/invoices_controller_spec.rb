# frozen_string_literal: true

require 'rails_helper'

RSpec.describe InvoicesController, type: :controller do
  let(:user) { create(:user) }
  let(:room) { create(:room, user:, electric_amount_old: 10, electric_amount_new: 20, water_amout_old: 30, water_amout_new: 40) }
  let(:invoice) { create(:invoice, room:) }

  before { sign_in(user) }

  describe 'GET #show_all_invoices' do
    it 'renders the show_all_invoices template' do
      get :show_all_invoices
      expect(response).to render_template(:show_all_invoices)
    end
  end

  describe 'GET #edit' do
    it 'renders the edit template' do
      get :edit, params: { room_id: room.id, id: invoice.id }
      expect(response).to render_template(:edit)
    end
  end

  describe 'POST #create' do
    let(:valid_params) { { room_id: room.id, invoice: attributes_for(:invoice) } }

    it 'creates a new invoice' do
      expect do
        post :create, params: valid_params
      end.to change(Invoice, :count).by(1)

      expect(response).to redirect_to(show_all_invoices_invoices_path)
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the invoice' do
      invoice # Ensure the invoice is created
      expect do
        delete :destroy, params: { room_id: room.id, id: invoice.id }
      end.to change(Invoice, :count).by(-1)

      expect(response).to redirect_to(show_all_invoices_invoices_path)
    end
  end
end
