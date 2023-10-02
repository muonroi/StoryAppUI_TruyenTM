import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_flutter/icons_flutter.dart';
import 'package:muonroi/shared/settings/enums/theme/enum.code.color.theme.dart';
import 'package:muonroi/shared/settings/settings.main.dart';
import 'package:muonroi/features/Categories/bloc/categories_all_bloc.dart';
import 'package:muonroi/features/Categories/settings/settings.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  @override
  void initState() {
    categoriesBloc.add(GetCategoriesEventList());
    super.initState();
  }

  @override
  void dispose() {
    categoriesBloc.close();
    super.dispose();
  }

  CategoriesBloc categoriesBloc = CategoriesBloc(1, 24);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.pop(context),
            color: themMode(context, ColorCode.textColor.name),
          ),
          backgroundColor: themMode(context, ColorCode.modeColor.name),
          elevation: 0,
        ),
        body: BlocProvider(
          create: (context) => categoriesBloc,
          child: BlocListener<CategoriesBloc, CategoriesState>(
            listener: (context, state) {
              const Center(child: CircularProgressIndicator());
            },
            child: BlocBuilder<CategoriesBloc, CategoriesState>(
              builder: (context, state) {
                if (state is CategoriesLoadingState) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is CategoriesLoadedState) {
                  return GridView.count(
                      scrollDirection: Axis.vertical,
                      childAspectRatio: (1 / .4),
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      children: List.generate(
                          state.categories.result.items.length, (index) {
                        var categoryInfo = state.categories.result.items[index];
                        var iconData =
                            _getIconDataFromApiResponse(categoryInfo.iconName);
                        return Container(
                          padding: const EdgeInsets.all(8.0),
                          child: Align(
                            alignment: Alignment.center,
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  WidgetSpan(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: themMode(context,
                                              ColorCode.modeColor.name),
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                      child: Stack(children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 4.0),
                                                child:
                                                    Icon(iconData, size: 34)),
                                            Container(
                                              width: MainSetting
                                                      .getPercentageOfDevice(
                                                          context,
                                                          expectWidth: 110)
                                                  .width,
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 4.0),
                                              child: Text(
                                                categoryInfo.nameCategory,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                        showToolTipHaveAnimationStories(
                                            categoryInfo.nameCategory,
                                            data: categoryInfo.id.toString(),
                                            context: context)
                                      ]),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }));
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ));
  }
}

IconData _getIconDataFromApiResponse(String iconName) {
  switch (iconName) {
    case 'clover':
      return RpgAwesome.clover;
    case 'flowers':
      return RpgAwesome.flowers;
    case 'two_dragons':
      return RpgAwesome.two_dragons;
    case 'croc_sword':
      return RpgAwesome.croc_sword;
    case 'dragon':
      return RpgAwesome.dragon;
    case 'love_howl':
      return RpgAwesome.love_howl;
    case 'fairy':
      return RpgAwesome.fairy;
    case 'skull_trophy':
      return RpgAwesome.skull_trophy;
    case 'clockwork':
      return RpgAwesome.clockwork;
    case 'gemini':
      return RpgAwesome.gemini;
    case 'arson':
      return RpgAwesome.arson;
    case 'eye_shield':
      return RpgAwesome.eye_shield;
    case 'eyeball':
      return RpgAwesome.eyeball;
    case 'tombstone':
      return RpgAwesome.tombstone;
    case 'burning_book':
      return RpgAwesome.burning_book;
    case 'frost_emblem':
      return RpgAwesome.frost_emblem;
    case 'hydra_shot':
      return RpgAwesome.hydra_shot;
    case 'incense':
      return RpgAwesome.incense;
    case 'explosive_materials':
      return RpgAwesome.explosive_materials;
    case 'duel':
      return RpgAwesome.duel;
    case 'doubled':
      return RpgAwesome.doubled;
    case 'blast':
      return RpgAwesome.blast;
    case 'book':
      return RpgAwesome.book;
    default:
      return Icons.error;
  }
}
