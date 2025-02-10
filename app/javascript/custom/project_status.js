document.addEventListener("turbo:load", function() {
  const statusSelect = document.getElementById("status-select");
  const statusForm = document.getElementById("status-form");
  
  if (statusSelect) {
    statusSelect.addEventListener("change", function() {
      const formData = new FormData(statusForm);
      const csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content");
      
      fetch(statusForm.action, {
        method: "PATCH",
        headers: {
          "X-CSRF-Token": csrfToken,
          "Accept": "application/json",
          "X-Requested-With": "XMLHttpRequest"
        },
        body: formData
      })
      .then(response => {
        if (!response.ok) {
          throw new Error('Network response was not ok');
        }
        return response.json();
      })
      .then(data => {
        if (data.success) {
          // Refresh the history section
          fetch(`${statusForm.action}/history?page=1`)
            .then(response => response.text())
            .then(html => {
              document.getElementById('history-section').innerHTML = html;
            })
            .catch(error => console.error("Error updating history:", error));
        } else {
          console.error("Failed to update status");
          statusSelect.value = statusSelect.getAttribute('data-previous-value');
        }
      })
      .catch(error => {
        console.error("Error:", error);
        statusSelect.value = statusSelect.getAttribute('data-previous-value');
      });

      // Store the current value for potential rollback
      statusSelect.setAttribute('data-previous-value', statusSelect.value);
    });
  }
});