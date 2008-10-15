module Mocks

  def stub_question(options = {})
    stub_model(Question, {
        :question => Faker::Lorem.sentence,
      }.update(options))        
  end
end
