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
    expect(find('#submit')).not_to have_button('submit')
  end
  it "spell checking message appears on submit", :js => true  do
    visit("/")
    fill_in('textarea', :with => 'Hello this is sample text')
    click_on('submit')
    expect(find('#error')).to have_content()
  end
  it "can check spelling for accuracy", :js => true  do
    visit("/")
    fill_in('textarea', :with => 'Hello this is sample text')
    click_on('submit')
    expect(find('#accuracy')).to have_content('Accuracy')
  end
end
