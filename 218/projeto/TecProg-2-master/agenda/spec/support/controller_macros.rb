module ControllerMacros
    def nova_atividade
        before(:each) do
            @request.env["devise.mapping"] = Devise.mappings[:atividade]
            atividade = FactoryGirl.create(:atividade)
        end
    end
end