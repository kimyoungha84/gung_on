package kr.co.gungon.util;

public class PageUtil {
    private int startRow;
    private int endRow;
    private StringBuffer page;

    public PageUtil(int currentPage, int count, int rowCount) {
        this(null, null, currentPage, count, rowCount, 0, null, null);
    }

    public PageUtil(int currentPage, int count, int rowCount,
                    int pageCount, String pageUrl) {
        this(null, null, currentPage, count, rowCount, pageCount, pageUrl, null);
    }

    public PageUtil(int currentPage, int count, int rowCount,
                    int pageCount, String pageUrl, String addKey) {
        this(null, null, currentPage, count, rowCount, pageCount, pageUrl, addKey);
    }

    public PageUtil(String keyfield, String keyword, int currentPage, int count,
                    int rowCount, int pageCount, String pageUrl) {
        this(keyfield, keyword, currentPage, count, rowCount, pageCount, pageUrl, null);
    }

    public PageUtil(String keyfield, String keyword, int currentPage, int count,
                    int rowCount, int pageCount, String pageUrl, String addKey) {

        if (count >= 0) {
            String sub_url = "";
            if (keyword != null) sub_url = "&keyfield=" + keyfield + "&keyword=" + keyword;
            if (addKey != null) sub_url += addKey;

            int totalPage = (int) Math.ceil((double) count / rowCount);
            if (totalPage == 0) totalPage = 1;
            if (currentPage > totalPage) currentPage = totalPage;

            startRow = (currentPage - 1) * rowCount + 1;
            endRow = currentPage * rowCount;

            page = new StringBuffer();

            if (pageCount > 0) {
                int startPage = (int) ((currentPage - 1) / pageCount) * pageCount + 1;
                int endPage = startPage + pageCount - 1;
                if (endPage > totalPage) endPage = totalPage;

                page.append("<div class='pagination-wrapper'><ul class='pagination'>");

                if (currentPage > pageCount) {
                    page.append("<li class='page-item'><a class='page-link' href='")
                        .append(pageUrl).append("?pageNum=").append(startPage - 1).append(sub_url)
                        .append("'>이전</a></li>");
                }

                for (int i = startPage; i <= endPage; i++) {
                    if (i > totalPage) break;

                    if (i == currentPage) {
                        page.append("<li class='page-item active'><span class='page-link'>")
                            .append(i).append("</span></li>");
                    } else {
                        page.append("<li class='page-item'><a class='page-link' href='")
                            .append(pageUrl).append("?pageNum=").append(i).append(sub_url)
                            .append("'>").append(i).append("</a></li>");
                    }
                }

                if (totalPage - startPage >= pageCount) {
                    page.append("<li class='page-item'><a class='page-link' href='")
                        .append(pageUrl).append("?pageNum=").append(endPage + 1).append(sub_url)
                        .append("'>다음</a></li>");
                }

                page.append("</ul></div>");
            } else {
                page.append("<b>[warning]</b>pageCount는 1이상 지정해야 페이지수가 표시됩니다.");
            }
        }
    }

    public StringBuffer getPage() {
        return page;
    }

    public int getStartRow() {
        return startRow;
    }

    public int getEndRow() {
        return endRow;
    }
}
