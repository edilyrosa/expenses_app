import 'package:expenses_app/main.dart';
import 'package:expenses_app/models/transaction.dart';
import 'package:expenses_app/widgets/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions; //list of trans. ultimos 7 dias
  Chart(this.recentTransactions);

  //var q obtene la info return por en interior del getter
  List<Map<String, Object>> get groupedTransactionValues {
    //getter de las transacciones agrupadas por dia de la semana.
    //(Pudo ser un model) Debe devolver una lista de 7 barras. Los items de la lista son Maps
    //Cada Map tendra contenido mixto(key strings y values Objs(pq tendran valor mixto))
    //getter necesita un cuerpo donde return la List, lo hacemos con el constructor .generate() q nos genera una nueva lista
    //espera la longitud y una funcion q se llamara para cada elemento

    return List.generate(7, (index) {
      //?que dia de la semana estamos generando?
      final weekDay = DateTime.now().subtract(Duration(days: index));

      //Final y no var pq en cada ejecusion el valor sera final y a lo largo de este archivo no cambiara ese valor
      //Hoy es DateTime.now() -> index = 0, hoy = 0
      //con subtract() restamos la duracion para obtener un nuevo fecha
      //subtract(Duration(days: 0) 1er loop, sera 0 dias, no resta nada, es HOY
      //subtract(Duration(days: 1) 2er loop, sera 1 dias, restaremos 1 dia, nos dara la fecha de AYER y asi
      //weekDay es una fecha, y como tal podemos acceder a sus propiedades
      //Obtengo la inicial de los dias DateFormat.E(weekDay),

      //?Generando Monto por dia y luego resumirlas?
      var totalSum = 0.0;
      //var pq la inicielize y dart infiere su TDD
      //Fuese double y no var SINO la inicie, Dart no sabria q tipo tendra.
      for (int i = 0; i < recentTransactions.length; i++) {
        //evaluando todas las transacciones de los 7 dias
        //weekDay es una fecha, y como tal podemos acceder a sus propiedades
        //Sabre que paso cada dia de la semana que estoy recorriendo
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          //y por dia me dara la siguiente sumatoria acumulada
          totalSum += recentTransactions[i].amount;
        }
      }

      return {
        //Cada Map de la List, representa la info por dia de la semana
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum,
      };
    });
  }

  double get totalSepnding {
    return groupedTransactionValues.fold(
        0.0, (sum, e) => sum + (e['amount'] as double));
  }
  //getter para saber el gasto total por la semana

  @override
  Widget build(BuildContext context) {
    print(groupedTransactionValues);
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(5),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: groupedTransactionValues.map((tx) {
              return Flexible(
                fit: FlexFit.tight,
                child: ChartBar(
                    tx['day'].toString(),
                    (tx['amount'] as double),
                    totalSepnding == 0.0
                        ? 0.0
                        : (tx['amount'] as double) / totalSepnding),
              );
            }).toList()),
      ),
    );
  }
}
