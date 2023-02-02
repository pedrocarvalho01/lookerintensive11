connection: "tpchlooker"

# include all the views
include: "/views/**/*.view"

datagroup: pedrocarvalho_looker11_default_datagroup {
  sql_trigger: SELECT max(l_orderkey) FROM f_lineitems;;
  max_cache_age: "1 hour"
}

persist_with: pedrocarvalho_looker11_default_datagroup

# explore: d_customer {}

# explore: d_dates {}

# explore: d_part {}

# explore: d_supplier {}

explore: f_lineitems {

  persist_with: pedrocarvalho_looker11_default_datagroup

  join: d_supplier {
    type: left_outer
    relationship: many_to_one
    sql_on: ${d_supplier.s_suppkey} = ${f_lineitems.l_suppkey} ;;
  }

  join: d_part {
    type: left_outer
    relationship: many_to_one
    sql_on: ${d_part.p_partkey} = ${f_lineitems.l_partkey} ;;
  }

  join: d_customer {
    type: left_outer
    relationship: many_to_one
    sql_on: ${d_customer.c_custkey} = ${f_lineitems.l_custkey} ;;
  }

  join: d_dates_order {
    from: d_dates
    view_label: "D Date Order "
    relationship: many_to_many
    sql_on: ${d_dates_order.datekey} = ${f_lineitems.l_orderdatekey} ;;
  }

  join: d_dates_ship {
    from: d_dates
    view_label: "D Date Ship "
    relationship: many_to_many
    sql_on: ${d_dates_ship.datekey} = ${f_lineitems.l_shipdatekey} ;;
  }

  join: d_dates_receipt {
    from: d_dates
    view_label: "D Date Receipt "
    relationship: many_to_many
    sql_on: ${d_dates_receipt.datekey} = ${f_lineitems.l_receiptdatekey} ;;
  }

}
