{% if page.prev or page.next %}
  <nav class="pagination">
    {{
      paginator({
        mid_size: 1
      })
    }}
  </nav>
{% endif %}
