package kr.co.gungon.pagination;

import javax.servlet.http.HttpServletRequest;

public class PaginationBuilder {
    private int currentPage;
    private int pageSize;
    private int rowCounts;
    private int totalPages;
    private int startPage;
    private int endPage;

    // HttpServletRequest 객체를 받아 currentPage 값을 처리하도록 변경
    /**
     * request : request 객체
     * pageSize : 페이지에서 보여줄 데이터 수
     * rowCounts : 조회한 총 데이터의 수
     * @param request 
     * @param pageSize 
     * @param rowCounts
     */
    public PaginationBuilder(HttpServletRequest request, int pageSize, int rowCounts) {
        this.pageSize = pageSize;
        this.rowCounts = rowCounts;

        // currentPage 값 처리 (request에서 가져오고, null 또는 잘못된 값은 1번 페이지로 설정)
        String currentPageParam = request.getParameter("currentPage");
        if (currentPageParam != null && !currentPageParam.isEmpty()) {
            try {
                this.currentPage = Integer.parseInt(currentPageParam);
            } catch (NumberFormatException e) {
                this.currentPage = 1;  // 잘못된 값은 1번 페이지로 설정
            }
        } else {
            this.currentPage = 1;  // null일 경우 1번 페이지로 설정
        }

        // 페이지 관련 계산
        this.totalPages = (int) Math.ceil((double) rowCounts / pageSize);
        if (this.currentPage < 1) this.currentPage = 1; // 최소 1페이지
        if (this.currentPage > totalPages) this.currentPage = totalPages; // 최대 totalPages 페이지

        // 페이지 그룹 계산 (5개씩 페이지 그룹으로 묶음)
        this.startPage = ((this.currentPage - 1) / 5) * 5 + 1;
        this.endPage = Math.min(startPage + 4, totalPages);
    }

    // 페이지네이션 HTML을 반환하는 메서드
    public String build(String baseUrl) {
        StringBuilder sb = new StringBuilder();

        sb.append(getPaginationCss());

        sb.append("<div class='pagination-wrapper'>");
        sb.append("<ul class='pagination'>");

        // 이전 페이지 링크
        sb.append("<li class='page-item " + (currentPage == 1 ? "disabled" : "") + "'>");
        sb.append("<a href='" + baseUrl + "?currentPage=" + (currentPage - 1) + "' class='page-link' aria-label='Previous'>");
        sb.append("<span aria-hidden='true'>&laquo;</span>");
        sb.append("</a>");
        sb.append("</li>");

        // 페이지 번호들
        for (int i = startPage; i <= endPage; i++) {
            sb.append("<li class='page-item " + (i == currentPage ? "active" : "") + "'>");
            sb.append("<a href='" + baseUrl + "?currentPage=" + i + "' class='page-link'>" + i + "</a>");
            sb.append("</li>");
        }

        // 다음 페이지 링크
        sb.append("<li class='page-item " + (currentPage == totalPages ? "disabled" : "") + "'>");
        sb.append("<a href='" + baseUrl + "?currentPage=" + (currentPage + 1) + "' class='page-link' aria-label='Next'>");
        sb.append("<span aria-hidden='true'>&raquo;</span>");
        sb.append("</a>");
        sb.append("</li>");

        sb.append("</ul>");
        sb.append("</div>");

        return sb.toString();
    }
    
    
    
    public String build(String baseUrl, String extraParams) {
        StringBuilder sb = new StringBuilder();

        sb.append(getPaginationCss());
        sb.append("<div class='pagination-wrapper'>");
        sb.append("<ul class='pagination'>");

        // extraParams가 null 또는 빈 문자열이면 빈 문자열로 처리
        String extra = (extraParams == null || extraParams.isEmpty()) ? "" : "&" + extraParams;

        // 이전 페이지 링크
        sb.append("<li class='page-item " + (currentPage == 1 ? "disabled" : "") + "'>");
        sb.append("<a href='" + baseUrl + "?currentPage=" + (currentPage - 1) + extra + "' class='page-link' aria-label='Previous'>");
        sb.append("<span aria-hidden='true'>&laquo;</span>");
        sb.append("</a>");
        sb.append("</li>");

        // 페이지 번호들
        for (int i = startPage; i <= endPage; i++) {
            sb.append("<li class='page-item " + (i == currentPage ? "active" : "") + "'>");
            sb.append("<a href='" + baseUrl + "?currentPage=" + i + extra + "' class='page-link'>" + i + "</a>");
            sb.append("</li>");
        }

        // 다음 페이지 링크
        sb.append("<li class='page-item " + (currentPage == totalPages ? "disabled" : "") + "'>");
        sb.append("<a href='" + baseUrl + "?currentPage=" + (currentPage + 1) + extra + "' class='page-link' aria-label='Next'>");
        sb.append("<span aria-hidden='true'>&raquo;</span>");
        sb.append("</a>");
        sb.append("</li>");

        sb.append("</ul>");
        sb.append("</div>");

        return sb.toString();
    }


    private String getPaginationCss() {
        return "<style>" +
               ".pagination-wrapper { text-align: center; margin-top: 20px; }" +
               ".pagination { display: inline-flex; list-style-type: none; padding: 0; margin: 0; }" +
               ".page-item { margin: 0 5px; }" +
               ".page-link { display: block; padding: 8px 16px; font-size: 16px; font-weight: 600; text-decoration: none; color: #007bff; border: 1px solid #007bff; border-radius: 4px; transition: all 0.3s ease; }" +
               ".page-link:hover { background-color: #007bff; color: white; }" +
               ".page-item.active .page-link { background-color: #007bff; color: white; border-color: #007bff; }" +
               ".page-item.disabled .page-link { background-color: #f8f9fa; color: #6c757d; border-color: #ddd; pointer-events: none; }" +
               "@media (max-width: 768px) { .pagination-wrapper { font-size: 14px; } .page-link { padding: 6px 12px; } }" +
               "</style>";
    }
    
    // Getter and Setter 메서드
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
