require_relative "./spec_helper"

describe ObjectView::Page do

  it "Can generate a Page" do
    page = ObjectView::Page.new
    html_text = page.render
    html_doc = Nokogiri::HTML(html_text)

    html_tags = html_doc.xpath("//html")
    expect(html_tags.length).to eq 1
    expect(html_doc.xpath("//html/body").length).to eq 1
    expect(html_doc.xpath("//html/head").length).to eq 1
    expect(html_doc.xpath("//html/body").children.length).to eq 1
  end
  
  it "Can add elements to body of page" do
    page = ObjectView::Page.new
    page.body.add ObjectView::Div.new "First Div"
    html_doc = Nokogiri::HTML(page.render)

    body_elements = html_doc.xpath("//html/body").children.select{|c| c.class == Nokogiri::XML::Element}
    expect(body_elements.length).to eq 1
    expect(body_elements.first.xpath("//div").length).to eq 1
  end
  
  it "Cannot add elements like Div's to page or head (must be added to body)" do
    page = ObjectView::Page.new
    expect{
      page.add ObjectView::Div.new
    }.to raise_error(ObjectView::IllegalChildElementError)

    expect{
      page.head.add ObjectView::Div.new
    }.to raise_error(ObjectView::IllegalChildElementError)
  end
  
end