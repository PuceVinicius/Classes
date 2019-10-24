require 'rails_helper'

RSpec.describe AtividadesController, type: :routing do
    describe 'routing' do

        it 'routes to #index' do
            expect(get: '/atividades').to route_to('atividades#index')
        end

        it 'routes to #show' do
            expect(get: '/atividades/1').to route_to('atividades#show', id: '1')
        end

        it 'routes to #new' do
            expect(get: '/atividades/new').to route_to('atividades#new')
        end

        it 'routes to #update via PUT' do
            expect(put: '/atividades/1').to route_to('atividades#update', id: '1')
        end

        it 'routes to #update via PATCH' do
            expect(patch: '/atividades/1').to route_to('atividades#update', id: '1')
        end
    end
end