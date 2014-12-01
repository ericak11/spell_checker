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
  it "can check spelling for accuracy" do
    visit("/")
    fill_in('textarea', :with => 'Hello this is sample text')
    click_on('submit')
    save_and_open_page
    expect(page).to have_content("Accuracy")
  end
end
