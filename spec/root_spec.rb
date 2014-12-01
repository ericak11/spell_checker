describe("the root") do
  it "says Spell Checker" do
    visit("/")
    expect(page).to have_content("Spell Checker")
  end
  it "can input text into box" do
    visit("/")
    fill_in('textarea', :with => 'Hello this is sample text')
    click_on('submit')
  end
  it "submit button disapears on submit", :js => true  do
    visit("/")
    fill_in('textarea', :with => 'Hello this is sample text')
    click_on('submit')
    page.has_css?('#submit', :visible => false)
  end
  it "can check spelling for accuracy", :js => true  do
    Capybara.default_wait_time = 10
    visit("/")
    fill_in('textarea', :with => 'Hello this is sample text')
    click_on('submit')
    expect(page).to have_text("Hello")
  end
end
