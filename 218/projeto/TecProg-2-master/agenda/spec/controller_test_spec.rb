require 'rails_helper'

RSpec.describe AtividadesController, type: :controller do
    describe 'atividades controller request specs' do
        context 'GET #index' do
            it 'should success and render to index page' do
                get :index
                expect(response).to have_http_status(200)
                expect(response).to render_template :index
            end
        end

        context 'GET #show' do
            let!(:atividade) { FactoryGirl.create(:atividade) }

            it 'should success and render to show page' do
                get :show, params: { id: atividade.id }
                expect(response).to have_http_status(200)
                expect(response).to render_template :show
            end
        end

        context 'PUT #update' do
            let!(:atividade) { FactoryGirl.create(:atividade) }

            it 'should update atividade attributes' do
                params = {
                    nome: 'Analise',
                    horario_inicio: '2010-06-24 12:00',
                    horario_fim: '2010-06-24 12:15',
                    sala: 'saguão',
                    professor: 'Puce'
                }

                put :update, params: { id: atividade.id, atividade: params }
                atividade.reload
                params.keys.each do |key|
                    expect(atividade.attributes[key.to_s]).to eq params[key]
                end
            end
        end

        context 'DELETE #destroy' do
            let!(:atividade) { FactoryGirl.create(:atividade) }

            it 'should delete atividade' do
                expect { delete :destroy, params: { id: atividade.id } }.to change { Atividade.all.count }.by(-1)
            end
        end

    end
end