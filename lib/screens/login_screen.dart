import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //control para mostrar o ocultar la contraseña
  bool _obscure = true;

  // Crear el cerebro de la animacion
  StateMachineController? _controller;
  //SMI: STATE MACHINE INPUT
  SMIBool? _isChecking;
  SMIBool? _isHandsUp;
  SMITrigger? _trigSuccess;
  SMITrigger? _trigFail;



  @override
  Widget build(BuildContext context) {
    //Para obtener el tamaño de la pantalla
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(
                width: size.width,
                height: 200,
                child: RiveAnimation.asset(
                  'login-bear.riv',
                  stateMachines: ['Login Machine'],
                  //1.2 Vincular animación
                  onInit: (artboard){
                    _controller = StateMachineController.fromArtboard(
                      artboard,
                      'Login Machine'
                      );

                      //1.3 Verificar que inicio bien
                      if(_controller == null) return;
                      //agrega controlador al escenario/tablero
                      artboard.addController(_controller!);
                      //vinculamos variables
                      _isChecking = _controller!.findSMI('isChecking');
                      _isHandsUp = _controller!.findSMI('isHandsUp');
                      _trigSuccess = _controller!.findSMI('trigSuccess');
                      _trigFail = _controller!.findSMI('trigFail');
                    }
                  ),
              ),
              //para separar espacios entre los elementos
              SizedBox(height: 10),
              TextField(
                onChanged: (value) {
                  if (_isHandsUp != null) {
                    //no tapes los ojos al ver el email
                    _isHandsUp!.change(false);
                  }
                                  //si cheking es nulo
                if(_isChecking == null) return;
                //activar modo chismoso
                _isChecking!.change(true);
                },
                //para mostrar el teclado de email
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    hintText: 'Email',
                    prefixIcon: const Icon(Icons.email),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)
                    )
                )
              ),

              SizedBox(height: 10),
              // Contrasena
              TextField(
                onChanged: (value) {
                  if (_isChecking != null) {
                    //no tapes al ver el email
                    _isChecking!.change(false);
                  }
                  // si isCheking es nulo
                  if(_isHandsUp == null) return;
                  // actuvar modo chismoso
                  _isHandsUp!.change(true);
                },

                obscureText: _obscure,
                //para mostrar el teclado de email
                decoration: InputDecoration(
                    hintText: 'Contraseña',
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      //If, operador ternario
                      icon: Icon(
                        _obscure ? Icons.visibility : Icons.visibility_off
                      ),
                      onPressed: () {
                        //Refresca el icono de visibilidad de la contraseña
                        setState(() {
                          _obscure = !_obscure;
                        });
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)
                    )
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
