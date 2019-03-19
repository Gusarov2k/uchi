class TopUsersController < ApplicationController
  def index; end

  def create
    gh_url = params[:get_github_repo][:github_url].strip
    gh_url = gh_url.match %r{(?<http>\Ahttps?:\/\/github.com\/)(?<gh_user_name>[-\w].*)\/(?<gh_user_repo>[-\w].*)\b}
    if gh_url
      github = Github.new user: gh_url[2], repo: gh_url[3]
      @github = github.repositories.contribs.first(3)
    end
    render :index
  end

  def view_github
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "award_for_user",
               disposition: "inline",
               template: "top_users/view_github.html.erb",
               layout: "pdf.html"
      end
    end
  end

  def download_pdf
    html = render_to_string(action: :view_github, layout: "pdf.html")
    pdf = WickedPdf.new.pdf_from_string(html)

    send_data(pdf,
              filename: "my_pdf.pdf",
              encoding: "UTF-8",
              template: "top_users/view_github.html.erb",
              disposition: 'attachment')
  end

  # def download_zip(files)
  #   zip_stream = Zip::OutputStream.write_buffer do |zip|
  #     files.each.with_index(1) do |file, index|
  #       # file name must be uniq in archive
  #       zip.put_next_entry("#{file.name}--#{index}.#{file.extension}")
  #       zip.write(file.read.force_encoding('utf-8'))
  #     end
  #   end
  #   # important - rewind the steam
  #   zip_stream.rewind
  #   send_data zip_stream.read,
  #             type: 'application/zip',
  #             disposition: 'attachment',
  #             filename: 'files-archive.zip'
  # end
end
