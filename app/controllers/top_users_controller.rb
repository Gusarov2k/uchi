class TopUsersController < ApplicationController
  def index; end

  def find_github_contributions
    gh_url = params[:github_url].strip.match %r{(?<http>\Ahttps?:\/\/github.com\/)
                                                (?<user_name>[-\w].*)\/
                                                (?<user_repo>[-\w].*)\b}x
    if gh_url
      github = Github.new user: gh_url[:user_repo], repo: gh_url[:user_name]
      @github = github.repositories.contribs.first(3)
    end
    render :index
  end

  def download_pdf
    html = render_to_string(template: "top_users/view_github.html.erb", layout: "pdf.html")
    pdf = WickedPdf.new.pdf_from_string(html)

    send_data(pdf,
              filename: "user_#{params[:id]}_top.pdf",
              type: 'application/pdf',
              disposition: 'attachment')
  end

  def dec_zip
    require 'zip'
    stringio = Zip::OutputStream.write_buffer do |zip|
      dec_pdf = render_to_string(pdf: "_name.pdf", template: "top_users/view_github.html.erb", layout: "pdf.html")
      zip.put_next_entry("user_#{params[:id]}_top.pdf")
      zip << dec_pdf
    end
    stringio.rewind
    binary_data = stringio.sysread
    send_data(binary_data, type: 'application/zip', filename: "test_dec_page.zip")
  end
end
