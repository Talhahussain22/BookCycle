import 'package:bloc/bloc.dart';
import 'package:bookcycle/PostAuth/SellPage/repository/userlocation.dart';
import 'package:meta/meta.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationBloc() : super(LocationInitial()) {
    on<LocationGetButtonPressed>((event, emit) async{


      emit(LocationLoadingState());
      try
          {
            List<dynamic>? response=await UserLocation().getAddressFromLatLng();
            if(response==null)
              {
                return emit(LocationErrorState(error: 'Turn on your location, or check your internet connection'));
              }
            if(response.isNotEmpty)
              {
                String location=response[0];
                dynamic lat=response[1];
                dynamic lon=response[2];

                emit(LocationLoadedState(location: location,lat: lat,lon: lon));
              }


          }catch(e){
        emit(LocationErrorState(error: e.toString()));
      }

    });
  }
}
