(function (w, d, $) {
  'use strict';

  let $tblInvoice;

  $(function () {
    $('.calculateTotal').on('change', calculateTotal);

    $('#btnSave').on('click', createRow);

    consultProducts();
  });

  const consultProducts = function () {
    $.get('/Accounting/GetProducts')
      .done(function (resp) {
        let data = resp.data;
        let message = resp.message;

        if (typeof data != 'object')
          return;

        let tag;

        for (let { Key, Value } of data) {
          tag += `<option value='${Key}'>${Value}</option>`;
        }

        $('#cmbProducts').append(tag);

        console.log(data);
      })
      .fail();
  };

  const calculateTotal = function () {
    let quantity = parseInt($('#NumQuantity').val());
    let price = parseFloat($('#NumPrice').val());

    let total = quantity * price;

    $('#NumTotal').val(total);
  };

  const createRow = function () {
    let data = {
      IdProduct: $('#cmbProducts').val(),
      Product: $('#cmbProducts option:selected').text(),
      Quantity: $('#NumQuantity').val(),
      Price: $('#NumPrice').val(),
      Total: $('#NumTotal').val()
    };

    if ($tblInvoice)
      $tblInvoice
        .row
        .add(data)
        .draw();

    $('#mdlRegister').modal('hide');
  };

  $tblInvoice = $('#tblInvoice').DataTable({
    columns: [
      { data: 'IdProduct' },
      { data: 'Product' },
      { data: 'Quantity' },
      { data: 'Price' },
      { data: 'Total' },
      {
        data: null,
        defaultContent: `
          <div class='d-flex justify-content-around'>
            <button class='btn btn-circle btn btn-danger'>Eliminar</button>
          </div>`
      }
    ]
  });

})(window, document, jQuery);