require "rails_helper"

RSpec.describe 'destroy a study session' do
  it 'destroy study session' do
    user = User.create( name: 'Pablo Dee',
                        email: 'test@example.com',
                        password: 'password')
    visit '/'

    click_on 'Login'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password

    click_on 'Log In'

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    session1 = user.studySessions.create(topic: "Cheese Making", duration: 4, paired: true)
    visit '/study_sessions/new'
    fill_in 'Topic', with: 'Ruby'
    fill_in 'Duration', with: '2'
    check "Paired"
    click_on "Create Session"
    session2 = StudySession.last
    expect(current_path).to eq("/study_sessions/#{session2.id}")
    expect(page).to have_link('End Session')
    click_on "End Session"
    expect(current_path).to eq("/")
    expect(StudySession.last).to eq(session1)
  end
end