abstract class FavoriteStates {}

class FavoriteInitState extends FavoriteStates{}
class AddToFavoriteSuccess extends FavoriteStates{
  
}
class ErrorAddToFavorite extends FavoriteStates{}
class GetFavorite extends FavoriteStates{}
class ErrorGetFavorite extends FavoriteStates{}
class DeleteFavorite extends FavoriteStates{}
class ErrorDeleteFavorite extends FavoriteStates{}

