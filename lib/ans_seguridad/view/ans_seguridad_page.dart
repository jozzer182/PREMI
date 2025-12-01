import 'package:flutter/material.dart';

import 'ans_seguridad_page_edit.dart';

// Modelo para los datos de contratos
class ContratoEvento {
  final String nombre;
  final String fechaInicio;
  final String fechaFin;
  final Color color;
  final IconData icono;
  final String tipo;

  ContratoEvento({
    required this.nombre,
    required this.fechaInicio,
    required this.fechaFin,
    required this.color,
    required this.icono,
    required this.tipo,
  });
}

class AnsSeguridadPage extends StatefulWidget {
  const AnsSeguridadPage({super.key});

  @override
  State<AnsSeguridadPage> createState() => _AnsSeguridadPageState();
}

class _AnsSeguridadPageState extends State<AnsSeguridadPage> {
  // Lista de meses
  final List<String> meses = [
    'ENE',
    'FEB',
    'MAR',
    'ABR',
    'MAY',
    'JUN',
    'JUL',
    'AGO',
    'SEP',
    'OCT',
    'NOV',
    'DIC',
  ];

  // Año actual
  final int anioActual = 2025;

  // Datos de ejemplo para contratos
  final List<String> contratos = [
    'JA10089990 INMEL INGENIERÍA SAS',
    'Contrato Servicios B456',
    'Contrato Mantenimiento C789',
    'Contrato Sistemas D012',
    'Contrato Limpieza E345',
    'Contrato Consultoría F678',
    'Contrato Infraestructura G901',
    'Contrato Renovación H234',
  ];

  // Eventos de contratos de ejemplo
  final List<ContratoEvento> eventos = [
    ContratoEvento(
      nombre: 'JA10089990 INMEL INGENIERÍA SAS',
      fechaInicio: 'Ene 1',
      fechaFin: 'Mar 15',
      color: Colors.green,
      icono: Icons.security,
      tipo: 'Activo',
    ),
    ContratoEvento(
      nombre: 'JA10089990 INMEL INGENIERÍA SAS',
      fechaInicio: 'Abr 1',
      fechaFin: 'Jun 15',
      color: Colors.green,
      icono: Icons.security,
      tipo: 'Activo',
    ),
    ContratoEvento(
      nombre: 'Contrato Servicios B456',
      fechaInicio: 'Feb 10',
      fechaFin: 'Abr 20',
      color: Colors.orange,
      icono: Icons.build,
      tipo: 'En revisión',
    ),
    ContratoEvento(
      nombre: 'Contrato Mantenimiento C789',
      fechaInicio: 'Mar 5',
      fechaFin: 'Jun 30',
      color: Colors.red,
      icono: Icons.healing,
      tipo: 'Urgente',
    ),
    ContratoEvento(
      nombre: 'Contrato Infraestructura G901',
      fechaInicio: 'May 15',
      fechaFin: 'Ago 15',
      color: Colors.blue,
      icono: Icons.business,
      tipo: 'Renovación',
    ),
    ContratoEvento(
      nombre: 'Contrato Renovación H234',
      fechaInicio: 'Jul 1',
      fechaFin: 'Oct 31',
      color: Colors.purple,
      icono: Icons.refresh,
      tipo: 'Planificado',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ANS Seguridad'),
        actions: [
          // IconButton(icon: const Icon(Icons.calendar_today), onPressed: () {}),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AnsSeguridadPageEdit(),
                ),
              );
            },
            child: const Text('CREAR\nSOLICITUD', textAlign: TextAlign.center),
          ),
          TextButton.icon(
            icon: const Icon(Icons.visibility),
            label: const Text('Ver todas las solicitudes'),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          _buildCalendarHeader(),
          _buildMonthsRow(),
          Expanded(child: _buildContratosCalendar()),
        ],
      ),
    );
  }

  // Encabezado del calendario
  Widget _buildCalendarHeader() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Calendario',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {},
              ),
              Text(
                '$anioActual',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.arrow_forward_ios),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Fila de meses
  Widget _buildMonthsRow() {
    return Container(
      height: 50,
      color: Colors.grey.shade200,
      child: Row(
        children: [
          // Columna fija para el título "CONTRATOS"
          SizedBox(
            width: 250,
            child: Center(
              child: Text(
                'CONTRATOS',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade700,
                ),
              ),
            ),
          ),
          // Grid de meses con tamaño fijo por cada mes
          Expanded(
            child: Row(
              children:
                  meses.map((mes) {
                    return Expanded(
                      flex: 1,
                      child: Center(
                        child: Text(
                          mes,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  // Calendario de contratos
  Widget _buildContratosCalendar() {
    return ListView.builder(
      itemCount: contratos.length,
      itemBuilder: (context, index) {
        final contrato = contratos[index];

        // Encontrar eventos para este contrato
        final eventosContrato =
            eventos.where((evento) => evento.nombre == contrato).toList();

        return _buildContratoRow(contrato, eventosContrato);
      },
    );
  }

  // Fila de contrato con sus eventos
  Widget _buildContratoRow(
    String contrato,
    List<ContratoEvento> eventosContrato,
  ) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
      ),
      child: Row(
        children: [
          // Nombre del contrato (columna fija)
          Container(
            width: 250,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        contrato,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
                Text('T01'),
                Spacer(),
              ],
            ),
          ),
          // Grid de meses para eventos
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Stack(
                  children:
                      eventosContrato.map((evento) {
                        // Calcular posición relativa en la grilla
                        final mesInicio = _obtenerNumeroMes(evento.fechaInicio);
                        final mesFin = _obtenerNumeroMes(evento.fechaFin);

                        // Calcular posiciones en porcentajes para estabilidad
                        final anchoTotal = constraints.maxWidth;
                        final anchoPorMes = anchoTotal / 12;
                        final posicionInicio = mesInicio * anchoPorMes;
                        final posicionFin = (mesFin + 1) * anchoPorMes;

                        return Positioned(
                          left: posicionInicio,
                          width: posicionFin - posicionInicio,
                          top: 10,
                          bottom: 10,
                          child: _buildEventoCard(evento),
                        );
                      }).toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Tarjeta de evento
  Widget _buildEventoCard(ContratoEvento evento) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      color: evento.color.withOpacity(0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: evento.color, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            Icon(evento.icono, color: evento.color, size: 18),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                '${evento.tipo}\n${evento.fechaInicio} - ${evento.fechaFin}',
                style: TextStyle(
                  fontSize: 12,
                  color: evento.color.withOpacity(0.8),
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.more_vert, size: 16),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  // Método para obtener el número de mes (0-11) a partir de una cadena como "Ene 15"
  int _obtenerNumeroMes(String fecha) {
    final mes = fecha.split(' ')[0].toLowerCase();
    switch (mes) {
      case 'ene':
        return 0;
      case 'feb':
        return 1;
      case 'mar':
        return 2;
      case 'abr':
        return 3;
      case 'may':
        return 4;
      case 'jun':
        return 5;
      case 'jul':
        return 6;
      case 'ago':
        return 7;
      case 'sep':
        return 8;
      case 'oct':
        return 9;
      case 'nov':
        return 10;
      case 'dic':
        return 11;
      default:
        return 0;
    }
  }
}
