require_relative "./spec_helper"

include ObjectView

describe ObjectView::Nav do

  it "Make a nav" do
    nav = ObjectView::Nav.new
    html_doc =  Nokogiri::HTML::fragment(nav.render)

    expect(html_doc.xpath("nav").length).to eq 1
  end
  
  
end