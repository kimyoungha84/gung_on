package kr.co.gungon.pagination;

import javax.servlet.http.HttpServletRequest;

public class PaginationBuilder {
    private int currentPage;
    private int pageSize;
    private int rowCounts;
    private int totalPages;
    private int startPage;
    private int endPage;

    public PaginationBuilder(HttpServletRequest request, int pageSize, int rowCounts) {
        this.pageSize = pageSize;
        this.rowCounts = rowCounts;

        try {
            this.currentPage = Integer.parseInt(request.getParameter("currentPage"));
        } catch (Exception e) {
            this.currentPage = 1;
        }

        this.totalPages = (int) Math.ceil((double) rowCounts / pageSize);
        this.currentPage = Math.max(1, Math.min(currentPage, totalPages));

        this.startPage = ((currentPage - 1) / 5) * 5 + 1;
        this.endPage = Math.min(startPage + 4, totalPages);
    }

    public String build(String baseUrl) {
        return build(baseUrl, "");
    }

    public String build(String baseUrl, String extraParams) {
        StringBuilder sb = new StringBuilder();
        String extra = (extraParams == null || extraParams.isEmpty()) ? "" : "&" + extraParams;

        boolean noData = (rowCounts == 0); // 데이터가 없는지 확인

        sb.append(getPaginationCss());
        sb.append("<div class='pagination-wrapper'><ul class='pagination'>");

        // 맨 처음 페이지
        sb.append(buildPageItem("≪", 1, currentPage == 1 || noData, baseUrl, extra));

        // 이전 페이지
        sb.append(buildPageItem("‹", currentPage - 1, currentPage == 1 || noData, baseUrl, extra));

        // 중간 페이지들
        for (int i = startPage; i <= endPage; i++) {
            sb.append("<li class='page-item " + (i == currentPage ? "active" : "") + "'>");
            sb.append("<a class='page-link' href='" + baseUrl + "?currentPage=" + i + extra + "'>" + i + "</a></li>");
        }

        // 다음 페이지
        sb.append(buildPageItem("›", currentPage + 1, currentPage == totalPages || noData, baseUrl, extra));

        // 맨 끝 페이지
        sb.append(buildPageItem("≫", totalPages, currentPage == totalPages || noData, baseUrl, extra));

        sb.append("</ul></div>");
        return sb.toString();
    }


    private String buildPageItem(String label, int page, boolean disabled, String baseUrl, String extra) {
        return "<li class='page-item " + (disabled ? "disabled" : "") + "'>" +
               "<a class='page-link' href='" + (disabled ? "#" : baseUrl + "?currentPage=" + page + extra) + "'>" +
               label + "</a></li>";
    }

    private String getPaginationCss() {
        return "<style>" +
               ".pagination-wrapper { text-align: center; margin-top: 20px; }" +
               ".pagination { display: inline-flex; gap: 6px; padding: 0; list-style: none; }" +
               ".page-item .page-link { padding: 6px 12px; font-size: 14px; color: #007bff; border: 1px solid #dee2e6; border-radius: 6px; text-decoration: none; transition: 0.2s; }" +
               ".page-item .page-link:hover { background-color: #007bff; color: #fff; }" +
               ".page-item.active .page-link { background-color: #007bff; color: #fff; border-color: #007bff; }" +
               ".page-item.disabled .page-link { color: #aaa; pointer-events: none; background-color: #f5f5f5; border-color: #ddd; }" +
               "@media (max-width: 768px) { .page-item .page-link { padding: 4px 8px; font-size: 12px; } }" +
               "</style>";
    }

	public int getCurrentPage() {
		return currentPage;
	}

	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public int getRowCounts() {
		return rowCounts;
	}

	public void setRowCounts(int rowCounts) {
		this.rowCounts = rowCounts;
	}

	public int getTotalPages() {
		return totalPages;
	}

	public void setTotalPages(int totalPages) {
		this.totalPages = totalPages;
	}

	public int getStartPage() {
		return startPage;
	}

	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}

	public int getEndPage() {
		return endPage;
	}

	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}

    
}
